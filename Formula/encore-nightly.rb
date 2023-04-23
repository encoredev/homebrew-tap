class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230423"
    checksums = {
        "darwin_arm64" => "695e3f2e471b3aa84bd8a46509901c4204899c6ffa482bcc12799bbd68e78d70",
        "darwin_amd64" => "efef770145d68d1df92beec7c7275eac4f878aab05a06e8ab34ba8227a4d65c7",
        "linux_arm64"  => "941d250895853359a38896ae61eee9532d3774a0ca5fddf998d413511a47ef6c",
        "linux_amd64"  => "f1d5cb357d9fadfe6388102f002e843788dbe347e5c5864f67bcde146717dd25",
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
