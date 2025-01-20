class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.45.8"
    checksums = {
        "darwin_arm64" => "61acccd2a1ebaea5f6bac1c75e6ffa999a14ab837ddef5625a8ad38ac0369eca",
        "darwin_amd64" => "be3602dd6139350c818709d8e28073917bb3b67808df45e5dd6b8eb182d72386",
        "linux_arm64"  => "59dde25124da519e73dd14364515af407fe4f3bafc20c44bb58ae1abe2183ef1",
        "linux_amd64"  => "1ebf45aad6db36c1c6f08c095e40592efe593874d2dfa2a70ba546d615772d6b",
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
