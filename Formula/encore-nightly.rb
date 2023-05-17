class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230517"
    checksums = {
        "darwin_arm64" => "4089dc05e344315c8eb85a155b644d6d4bb3a781e440fd1f04020146665397cb",
        "darwin_amd64" => "f2f6c8c2f5c92b0fbda49ca18f40a17e439ced52dc620bf8722f3d28fe4aca83",
        "linux_arm64"  => "9436e36b5c26679ec0685b6ec8adefa7ffca296b6b75a36f413e1524ac5fd71d",
        "linux_amd64"  => "6b570dc99c58b94eaa38fa84501f527f17605082c57b394be4b5771924860382",
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
