class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.51.9"
    checksums = {
        "darwin_arm64" => "6e0291a1463c15ba48f9e7e20eeaa17949fc87959391a03d8f4ff1ab77fe3109",
        "darwin_amd64" => "7822d198b5ad541d37dab4f4bfc285fa232ce4ee461bdfcc7bf494e4dbe3db45",
        "linux_arm64"  => "4eae4790db6984b80c37148b481a1b1ca856c892f978c60817063be85fd302a5",
        "linux_amd64"  => "f945286bbb41e4b328ea4e206f76d59748ec22f813900e4353e1c5f98871c046",
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
