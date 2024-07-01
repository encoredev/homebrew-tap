class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.39.1"
    checksums = {
        "darwin_arm64" => "1465345dadff72e09032dfcecaff3897882b77da6d9ac555265f8b3ac601e99f",
        "darwin_amd64" => "6f69dc061f5d0b4ddf341b57a3fb51d867e50badd0717eac31050366e651eb6b",
        "linux_arm64"  => "d8126312d696983d2a9640e6e2d1aac449fc2b9bca624954e1cb11aa75f8e4b7",
        "linux_amd64"  => "a53b6aa918cc708fab4219d4cd3ccdf267cfd8d0bee9fc2dd36d7071f7fde3d7",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
