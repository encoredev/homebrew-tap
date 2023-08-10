class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230810"
    checksums = {
        "darwin_arm64" => "97d7bfa6467937743e6b04af56ff3eca0643022bb7956d6248ba52b857a30c7e",
        "darwin_amd64" => "18224b2ac34f7e1c51d1af76d6c44d292ba59ed81e98a5c44a1c5dbf03923e06",
        "linux_arm64"  => "fc1daaf2eb5d6344c017e3ae81c156e5c177f3015574e90537e3acb29e3c3d39",
        "linux_amd64"  => "cdb48d7de45b52e3542b10acc18fb396f56e77047b6bc10acc577e29803589c5",
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
