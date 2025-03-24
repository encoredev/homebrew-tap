class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.13"
    checksums = {
        "darwin_arm64" => "aecc700db717ee5499b3e1a499f05fd800300dccc16cb84a4dae909aa2cd243f",
        "darwin_amd64" => "f2b6e9e0544b0199e5ef9e3ab87d111b549ee5119cb5b3156cfcf4220a83fa71",
        "linux_arm64"  => "b10a9ba55464a96c4f1539b7e9f374e80e2ee82449b8632751c36d42d68c882e",
        "linux_amd64"  => "e80a344ae6e972faa8a0721461831e73046ab5b97dbbb6274891e13846b4595b",
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
