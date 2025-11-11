class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.51.5"
    checksums = {
        "darwin_arm64" => "c7bb8dfc8ebdcd878336dad3be15ab0d76a4f73a60300d9c3d59733b01e42516",
        "darwin_amd64" => "3fba477d77fad35aa03c2feaff642f6f375b81ada74340f093fe5eb343badbd5",
        "linux_arm64"  => "dc028b7c7beb9e423ad0dde2efed8df82aa85905e5cea50c737e7cceb2ce6c66",
        "linux_amd64"  => "e979fde7a32f88706f95dc047e4e0281f147f62fdd830bd7a9628c00223d521d",
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
