class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.2"
    checksums = {
        "darwin_arm64" => "bbe873aefd61727e4ca7fa440bb2970355f0a8ca9dfaef719be3b7af1709b632",
        "darwin_amd64" => "c69c9ca6a656df5e287951b3a02d60b4ac5914105df9636a144a7072cd64bd5d",
        "linux_arm64"  => "a5f6c8aaa92da5ce35f5ef55c39fe68415c5c28a1323260d3d20e389b1df4bb9",
        "linux_amd64"  => "ef6a801a58be9c32b5c2457764cec7cacc4e59954c868601ba52026d792790d8",
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
